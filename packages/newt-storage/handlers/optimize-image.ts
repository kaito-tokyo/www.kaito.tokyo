import { basename, dirname } from "node:path";

import { type Request, type Response } from "@google-cloud/functions-framework";
import { Storage } from "@google-cloud/storage";
import sharp from "sharp";

export async function handleOptimizeImage(req: Request, res: Response) {
	const { inputBucket, inputObject, outputBucket } = req.query;

	if (
		typeof inputBucket !== "string" ||
		typeof inputObject !== "string" ||
		typeof outputBucket !== "string"
	) {
		throw new Error("Query is invalid!");
	}

	const storage = new Storage();

	const inputObjectDirname = dirname(inputObject);
	const inputObjectBasename = basename(inputObject);

	const [response] = await storage.bucket(inputBucket).file(inputObject).download();

	const outputObjects: string[] = [];

	const addOptimizedImage = async (name: string, image: sharp.Sharp) => {
		const buffer = await image.toBuffer();
		await storage.bucket(outputBucket).file(name).save(buffer);
		outputObjects.push(name);

		const metadataName = `${name}.metadata.json`;
		const metadata = await sharp(buffer).metadata();
		await storage.bucket(outputBucket).file(metadataName).save(JSON.stringify(metadata));

		outputObjects.concat(name, metadataName);
	};

	await addOptimizedImage(
		`${inputObjectDirname}/_thumbnail400/${inputObjectBasename}.webp`,
		sharp(response).resize(400, 400, { fit: "contain" }).webp()
	);

	await addOptimizedImage(
		`${inputObjectDirname}/_thumbnail400/${inputObjectBasename}.png`,
		sharp(response).resize(400, 400, { fit: "contain" }).png()
	);

	await addOptimizedImage(
		`${inputObjectDirname}/_artwork1600/${inputObjectBasename}.webp`,
		sharp(response).resize(1600, 1600, { fit: "contain" }).webp()
	);

	await addOptimizedImage(
		`${inputObjectDirname}/_artwork1600/${inputObjectBasename}.png`,
		sharp(response).resize(1600, 1600, { fit: "contain" }).png()
	);

	res.send({ outputObjects });
}
