import { type SecretManagerServiceClient } from "@google-cloud/secret-manager";

export async function getSecret(name: string, client: SecretManagerServiceClient): Promise<string> {
	const [version] = await client.accessSecretVersion({ name });
	const payload = version.payload?.data?.toString();
	if (!payload) {
		throw new Error(`Secret ${name} was not found!`);
	}
	return payload;
}
