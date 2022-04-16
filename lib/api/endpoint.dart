const baseUrl = 'http://10.0.2.2:4000/';
// const baseUrl = 'http://100.64.196.207:4000/';

const getUserToken = '${baseUrl}token/';

const registerUserEndPoint = '${baseUrl}user/register';

const loginUserEndPoint = '${baseUrl}user/login';

const postNewPropertyEndPoint = '${baseUrl}user/property';

const getAllPropertyEndpoint = '${baseUrl}property';

const getOwnPropertyEndpoint = '${baseUrl}user/property';

const deleteOwnPropertyEndpoint = '${baseUrl}user/property/';

const editOwnPropertyEndpoint = '${baseUrl}user/property/';

const getOwnerContactEndpoint = '${baseUrl}user/info/';

const likeOrUnlikePropertyEndpoint = '${baseUrl}like?propertyId=';

const bookmarkPropertyEndpoint = '${baseUrl}favourite?propertyId=';

const searchPropertyEndpoint = '${baseUrl}search/property/list?keyword=';

const getPropertyByTypeEndpoint = '${baseUrl}property/list?type=';

const getBookmarkedPropertyEndpoint = '${baseUrl}favourite';
