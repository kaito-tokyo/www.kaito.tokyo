import { formatInTimeZone } from "date-fns-tz";

export function getThumbnail400URL(origUrl: string, ext: string) {
    const url = new URL(origUrl);
    url.host = "www-img.kaito.tokyo";
    const [, , id, name] = url.pathname.split("/");
    url.pathname = `/${id}/_thumbnail400/${name}${ext}`;
    return url.toString();
}

export function formatPublishedAt(dateString: string): string {
    return formatInTimeZone(new Date(dateString), "Asia/Tokyo", "yyyy-MM-dd");
}
