class BedSerializer
    def initialize(obj)
        @bed = obj
    end

    def to_serialized_json
        format = {
            include: {
                stages: {
                    only: [:status, :start_date, :due_date]
                }
            },
            except: [:updated_at, :created_at]
        }
        @bed.as_json(format)
    end

end