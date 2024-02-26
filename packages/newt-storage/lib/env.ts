export function getEnv(name: string): string {
	const value = process.env[name];
	if (!value) {
		throw new Error(`An environmental varialbe ${name} is not defined!`);
	}
	return value;
}

export function lazyGetEnv(name: string): () => string {
	let value: string;
	return () => {
		if (!value) {
			value = getEnv(name);
		}
		return value;
	};
}

export const getCdnRegion = lazyGetEnv("CDN_REGION");
export const getCdnEndpoint = lazyGetEnv("CDN_ENDPOINT");
export const getCdnBucketName = lazyGetEnv("CDN_BUCKET_NAME");
export const getCdnAccessKeyIdSecretName = lazyGetEnv("CDN_ACCESS_KEY_ID_SECRET_NAME");
export const getCdnSecretAccessKeySecretName = lazyGetEnv("CDN_SECRET_ACCESS_KEY_SECRET_NAME");
