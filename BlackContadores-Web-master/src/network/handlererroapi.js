import Constants from '../util/constants'

export default function (error) {
    if (error.request.status === 404)
        return {
            status: error.request.status,
            message: Constants.error_400s
        }
    else if (error.request.status === 0 || error.request.status === 500)
        return {
            status: error.request.status,
            message: Constants.error_500s
        }
}