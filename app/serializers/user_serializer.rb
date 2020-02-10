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
                                    },
                                    todos: {
                                        except: [:updated_at, :created_at, :field_id, :bed_id, :user_id]
                                    }
                                },
                                except: [:updated_at, :created_at]
                            },
                            todos: {
                                include: {
                                    bed: {
                                        only: :name
                                    }
                                },
                                except: [:updated_at, :created_at, :field_id, :user_id]
                            }
                        }
                    },
                    todos: {
                        include: {
                            field: {
                                only: :name
                            },
                            bed: {
                                only: :name
                            }
                        },
                        except: [:created_at, :user_id, :updated_at]
                    }
                },
            except: [:password_digest]
            }

        @user.as_json(format)
    end

end