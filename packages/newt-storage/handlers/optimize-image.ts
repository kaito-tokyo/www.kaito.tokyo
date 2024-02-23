import { basename, dirname } from "node:path";

import { type Request, type Response } from "@google-cloud/functions-framework";
import sharp from "sharp";

import { storage } from "./constants.js";

export async function handleOptimizeImage(req: Request, res: Response) {
	const { bucket, object } = req.query;

	if (typeof bucket !== "string" || typeof object !== "string") {
		throw new Error("Query is invalid!");
	}

	const objectDirname = dirname(object);
	const objectBasename = basename(object);

	const [response] = await storage.bucket(bucket).file(object).download();

	let name: string;
	let buffer: Buffer;

	name = `${objectDirname}/_thumbnail400/${objectBasename}.webp`;
	buffer = await sharp(response).resize(400, 400, { fit: "contain" }).webp().toBuffer();
	await storage.bucket(bucket).file(name).save(buffer);

	name = `${objectDirname}/_thumbnail400/${objectBasename}.png`;
	buffer = await sharp(response).resize(400, 400, { fit: "contain" }).png().toBuffer();
	await storage.bucket(bucket).file(name).save(buffer);

	res.status(204).send("");
}
