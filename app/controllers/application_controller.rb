class ApplicationController < ActionController::API
    
    
        def encode_token(payload)
            JWT.encode(payload, 's3cr3t')
        end
    
        # #This method looks at HTTP request for key of 'Authorization' with 
        # #format of Bearer <token>. This method returns a token.
        def auth_header
            # { 'Authorization': 'Bearer <token>' }
            request.headers['Authorization']
        end 
    
        # #This method returns an array from JWT.decode. We only care about
        # #the first index: key of user_id, which is used in current_user method
        def decoded_token
            if auth_header
                token = auth_header.split(' ')[1]
                begin
                    JWT.decode(token, 's3cr3t', true, algorithm: 'HS256')
                rescue JWT::DecodeError
                    nil
                end
            end
        end
    
        # #This method checks if a User instance with that ID
        # #exists in the database. If so, it's authorized.
        # #This is the previously logged in user.
        def current_user
            if decoded_token
                user_id = decoded_token[0]['user_id']
                @user = User.find_by(id: user_id)
            end
        end
    
        def logged_in?
            !!current_user
        end
    
        def authorized
            render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
        end
    
    end