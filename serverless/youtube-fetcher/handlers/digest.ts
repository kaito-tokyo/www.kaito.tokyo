import { createHash } from "crypto";
import { type Request, type Response } from "@google-cloud/functions-framework";

export async function handleDigest(req: Request, res: Response) {
    const { rawBody } = req;

    if (typeof rawBody === "undefined") {
        throw new Error("Body is missing!")
    }

    const digest = createHash("sha256").update(rawBody).digest("hex");

    res.send(digest);
}
