class FavoriteSerializer
    def initialize(obj)
        @favorite = obj
    end

    def to_serialized_json
        format = {
            include: {
                crop: {
                    except: [:created_at, :updated_at]
                }
            },
            except: [:created_at, :updated_at, :user_id]
        }

        @favorite.as_json(format)
    end
end