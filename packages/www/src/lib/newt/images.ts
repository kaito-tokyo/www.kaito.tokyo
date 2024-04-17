import { formatInTimeZone } from "date-fns-tz";

export function getThumbnail400URL(origURL: string, ext: string) {
	const url = new URL(origURL);
	url.host = "www-img.kaito.tokyo";
	const [, , id, name] = url.pathname.split("/");
	url.pathname = `/${id}/_thumbnail400/${name}${ext}`;
	return url.toString();
}

export function getArtwork1600URL(origURL: string, ext: string) {
	const url = new URL(origURL);
	url.host = "www-img.kaito.tokyo";
	const [, , id, name] = url.pathname.split("/");
	url.pathname = `/${id}/_artwork1600/${name}${ext}`;
	return url.toString();
}

export function getMetadataURL(origURL: string) {
    return `${origURL}.metadata.json`;
}

export interface OptimizedImageMetadata {
    width: number;
    height: number;
}

export function formatPublishedAt(dateString: string): string {
	return formatInTimeZone(new Date(dateString), "Asia/Tokyo", "yyyy-MM-dd");
}
