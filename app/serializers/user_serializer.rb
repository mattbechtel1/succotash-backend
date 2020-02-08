class UserSerializer
    def initialize(obj)
        @user = obj
    end

    def to_serialized_json
        format = {
            include: {
                    fields: {
                        include: {
                            beds: {
                                include: {
                                    stages: {
                                        except: [:updated_at, :created_at]
                                    }
                                },
                                except: [:updated_at, :created_at]
                            }
                        }
                    },
                    todos: {
                        except: [:created_at, :user_id, :updated_at]
                    }
                },
            except: [:password_digest]
            }

        @user.as_json(format)
    end

end