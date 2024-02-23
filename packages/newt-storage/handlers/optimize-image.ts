import { type Request, type Response } from "@google-cloud/functions-framework";
import sharp from "sharp";

import { storage } from "./constants.js";

export async function handleOptimizeImage(req: Request, res: Response) {
	const { bucket, object } = req.query;

	if (typeof bucket !== "string" || typeof object !== "string") {
		throw new Error("Query is invalid!");
	}

	const [response] = await storage.bucket(bucket).file(object).download();

	const outputNames = [`_thumbnail400-webp/${object}.webp`];

	const outputBuffers = await Promise.all([
		sharp(response).resize(400, 400, { fit: "contain" }).toBuffer()
	]);

	await Promise.all(
		outputNames.map(async (name, index) => {
			const buffer = outputBuffers[index];

			if (!buffer) {
				return Promise.resolve();
			}

			await storage.bucket(bucket).file(name).save(buffer);
		})
	);

	res.status(204).send("");
}
