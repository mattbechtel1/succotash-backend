class BedSerializer
    def initialize(obj)
        @bed = obj
    end

    def to_serialized_json
        format = {
            include: {
                stages: {
                    include: {
                        crop: {
                            except: [:updated_at, :created_at]
                        }
                    },
                    except: [:updated_at, :created_at]
                },
                todos: {
                    except: [:updated_at, :created_at, :field_id, :bed_id, :user_id]
                }
            },
            except: [:created_at]
        }
        @bed.as_json(format)
    end

end