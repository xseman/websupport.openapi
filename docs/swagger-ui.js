// @ts-check
import swagger from "swagger-ui-dist";
import crypto from "crypto-js";

swagger.SwaggerUIBundle({
	// url: "http://localhost:8000/openapi.yaml",
	url: 'https://raw.githubusercontent.com/xseman/websupport.openapi/master/openapi.yaml',
	dom_id: "#swagger-ui",
	deepLinking: true,
	persistAuthorization: true,
	requestInterceptor: websupportAuth,
});

/**
 * @param {swagger.SwaggerRequest} req 
 */
function websupportAuth(req) {
	const auth = JSON.parse(window.localStorage.getItem("authorized"));
	if (auth) {
		const {
			username: apiKey, 
			password: secret
		} = auth.basicAuth.value;
		const date = new Date().toISOString();
		const path = new URL(req.url).pathname;
		const signature = crypto
			.HmacSHA1(`${req.method} ${path} ${date}`, secret)
			.toString(crypto.enc.Hex);

		console.log(req.method, path, date);
		req.headers = {
			...req.headers,
			Date: date,
			Authorization: "Basic " + window.btoa(apiKey + ":" + signature),
		};
	}

	return req;
}

