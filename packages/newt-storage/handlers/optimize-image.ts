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

	let name: string;
	let buffer: Buffer;
	const outputObjects: string[] = [];

	name = `${inputObjectDirname}/_thumbnail400/${inputObjectBasename}.webp`;
	buffer = await sharp(response).resize(400, 400, { fit: "contain" }).webp().toBuffer();
	await storage.bucket(outputBucket).file(name).save(buffer);
	outputObjects.push(name);

	name = `${inputObjectDirname}/_thumbnail400/${inputObjectDirname}.png`;
	buffer = await sharp(response).resize(400, 400, { fit: "contain" }).png().toBuffer();
	await storage.bucket(outputBucket).file(name).save(buffer);
	outputObjects.push(name);

	res.send({ outputObjects });
}
