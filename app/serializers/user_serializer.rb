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
                    },
                    favorites: {
                        include: {
                            crop: {
                                except: [:created_at, :updated_at]
                            }
                        },
                        except: [:created_at, :updated_at, :user_id]
                    }
                },
            except: [:password_digest]
            }

        @user.as_json(format)
    end

end