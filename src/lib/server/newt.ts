import { createClient, type Image } from 'newt-client-js';
import { NEWT_SPACE_UID, NEWT_CDN_API_TOKEN } from '$env/static/private';

export interface IllustrationTag {
    _id: string
    name: string
    slug: string
}

export interface IllustrationArticle {
    _id: string
    title: string
    slug: string
    images: Image[]
    publishDate: string
    description: string
    tags: IllustrationTag[]
}

export const newtClient = createClient({
	spaceUid: NEWT_SPACE_UID,
	token: NEWT_CDN_API_TOKEN,
	apiType: 'cdn'
});