class TodoSerializer
    def initialize(obj)
        @todo = obj
    end

    def to_serialized_json
        format = {
            include: {
                field: {
                    only: :name
                },
                bed: {
                    only: :name
                }
            },
            exclude: [:updated_at, :created_at]
        }

        @todo.as_json(format)
    end

end