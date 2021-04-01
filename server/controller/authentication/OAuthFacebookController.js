export default function buildOAuthFacebookController(axios) {
  const clientId = process.env.FACEBOOK_APP_ID;
  const clientSecret = process.env.FACEBOOK_APP_SECRET;
  let appLink =
    "https://graph.facebook.com/oauth/access_token?client_id=" +
    clientId +
    "&client_secret=" +
    clientSecret +
    "&grant_type=client_credentials";
  return async function (inputToken) {
    let response = await axios.get(appLink);
    console.log(response.data);
    let appToken = response.data.access_token;
    let link =
      "https://graph.facebook.com/debug_token?input_token=" +
       inputToken +
      "&access_token=" +
      appToken;
    response=await axios.get(link);
    let reciviedData=response.data;
    console.log(reciviedData.data.user_id);
    
    return reciviedData.data.user_id;
  };
}
