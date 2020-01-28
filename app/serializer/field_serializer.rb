class FieldSerializer
    def initialize(obj)
        @field = obj
    end

    def to_serialized_json
        format = {
            include: {
                beds: {
                    include: {
                        stages: {
                            only: [:cycle_stage, :start_date, :due_date, :tester]
                        }
                    },
                    except: [:updated_at, :created_at, :field_id]
                }
            },
            except: [:updated_at]
        }
        @field.as_json(format)
    end

end