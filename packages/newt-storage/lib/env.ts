export function getEnv(name: string): string {
	const value = process.env[name];
	if (!value) {
		throw new Error(`An environmental varialbe ${name} is not defined!`);
	}
	return value;
}

export const cdnRegion = getEnv("CDN_REGION");
export const cdnEndpoint = getEnv("CDN_ENDPOINT");
export const cdnBucketName = getEnv("CDN_BUCKET_NAME");
export const cdnAccessKeyIdSecretName = getEnv("CDN_ACCESS_KEY_ID_SECRET_NAME");
export const cdnSecretAccessKeySecretName = getEnv("CDN_SECRET_ACCESS_KEY_SECRET_NAME");
