import { User } from "./user.interface"



export interface CheckTokenReponse{
    user: User
    token: string
}