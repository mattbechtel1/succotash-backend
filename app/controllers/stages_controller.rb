class StagesController < ApplicationController
    def create
        bed = Bed.find(params[:bed_id])
        new_start_date = Date.parse(params[:start_date])

        if !params[:due_date]
            bed.stages.where('start_date > ?', new_start_date).destroy_all

            bed = Bed.find(params[:bed_id])
            if bed.stages.length > 0
                bed.stages.order(start_date: :desc)[0].update(due_date: new_start_date - 1.days)
            end
        else
            new_due_date = Date.parse(params[:due_date])

            # checks for stages that are completely overlapped by the new stage
            overlapped = bed.stages.where('start_date >= ? and due_date <= ?', new_start_date, new_due_date) 
            overlapped.destroy_all
            
            # edits the nil due_date stage if necessary
            nil_needs_end_date_adjustment = bed.stages.detect {|stage| stage.start_date < new_start_date && !stage.due_date }
            
            if nil_needs_end_date_adjustment
                nil_needs_end_date_adjustment.update(due_date: new_start_date - 1.day)
            end

            # edits the due_date when new stage overlaps at the end of old stage
            needs_end_date_pushed_back = bed.stages.detect { |stage| stage.start_date < new_start_date && stage.due_date >= new_start_date && stage.due_date < new_due_date}
            if needs_end_date_pushed_back
                needs_end_date_pushed_back.update(due_date: new_start_date - 1.day)
            end
            
            # clones and edits due_date when new stage is inserted completely into old stage without hitting either end
            needs_cloning = bed.stages.detect { |stage| stage.start_date < new_start_date && stage.due_date > new_due_date}
            if needs_cloning
                cloned_stage = needs_cloning.dup
                cloned_stage.start_date = new_due_date + 1.day
                needs_cloning.update(due_date: new_start_date - 1.day)

                cloned_stage.save
            end

            # checks for stages that are now overlapped at their beginning
            start_pushed_back = bed.stages.detect {|stage| stage.start_date >= new_start_date && stage.start_date < new_due_date && ((stage.due_date && stage.due_date > new_due_date) || !stage.due_date) } 

            if start_pushed_back
                start_pushed_back.update(start_date: new_due_date + 1.day)
            end
        end
        
        Stage.create(strong_params)

        bed = Bed.find(params[:bed_id])
        
        if !bed.stages.find_by(due_date: nil)
            Stage.create(start_date: new_due_date + 1, status: 'unused', bed: bed)
        end

        bed = Bed.find(params[:bed_id])

        render json: BedSerializer.new(bed).to_serialized_json
    end


    private

    def strong_params
        params.require(:stage).permit(:crop_id, :start_date, :due_date, :bed_id, :status)
    end
end