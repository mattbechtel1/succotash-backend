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
                            include: {
                                crop: {
                                    except: [:updated_at, :created_at]
                                }
                            },
                            except: [:updated_at, :created_at]
                        }
                    },
                    except: [:updated_at]
                }
            }
        }
        @field.as_json(format)
    end

end