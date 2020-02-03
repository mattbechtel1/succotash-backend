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
                            except: [:updated_at, :created_at]
                        }
                    },
                    except: [:updated_at, :created_at, :field_id]
                }
            }
        }
        @field.as_json(format)
    end

end