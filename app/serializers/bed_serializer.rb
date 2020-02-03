class BedSerializer
    def initialize(obj)
        @bed = obj
    end

    def to_serialized_json
        format = {
            include: {
                stages: {
                    except: [:updated_at, :created_at]
                }
            },
            except: [:updated_at, :created_at]
        }
        @bed.as_json(format)
    end

end