import { type Request, type Response } from "@google-cloud/functions-framework";
import { SecretManagerServiceClient } from "@google-cloud/secret-manager";
import { Storage } from "@google-cloud/storage";
import { S3Client, PutObjectCommand } from "@aws-sdk/client-s3";

import {
	getCdnRegion,
	getCdnEndpoint,
	getCdnBucketName,
	getCdnAccessKeyIdSecretName,
	getCdnSecretAccessKeySecretName
} from "../lib/env.js";

import { getSecret } from "../lib/secret.js";

export async function handleUploadObjectToCdn(req: Request, res: Response) {
	const { inputBucket, inputObject, outputObject } = req.query;

	if (
		typeof inputBucket !== "string" ||
		typeof inputObject !== "string" ||
		typeof outputObject !== "string"
	) {
		throw new Error("Query is invalid!");
	}

	const secretManagerClient = new SecretManagerServiceClient();
	const accessKeyId = await getSecret(getCdnAccessKeyIdSecretName(), secretManagerClient);
	const secretAccessKey = await getSecret(getCdnSecretAccessKeySecretName(), secretManagerClient);

	const s3 = new S3Client({
		region: getCdnRegion(),
		endpoint: getCdnEndpoint(),
		credentials: {
			accessKeyId,
			secretAccessKey
		}
	});

	const storage = new Storage();
	const [response] = await storage.bucket(inputBucket).file(inputObject).download();

	await s3.send(
		new PutObjectCommand({
			Bucket: getCdnBucketName(),
			Key: outputObject,
			Body: response
		})
	);

	res.status(204).send("");
}
