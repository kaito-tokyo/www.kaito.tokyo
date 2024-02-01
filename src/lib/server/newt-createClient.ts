import type {
	CreateClientParams,
	GetContentsParams,
	GetContentParams,
	GetFirstContentParams,
	Contents,
	GetAppParams,
	AppMeta
} from "newt-client-js";
import type { Query, FilterQuery } from "newt-client-js/dist/types/types";
import { stringify } from "qs";

const parseAndQuery = (andQuery: FilterQuery[]) => {
	if (!andQuery) throw new Error("invalid query");
	const rawAndConditions: string[] = [];
	const encodedAndConditions: string[] = [];

	andQuery.forEach((query: FilterQuery) => {
		const { raw, encoded } = parseQuery(query);
		rawAndConditions.push(raw);
		encodedAndConditions.push(encoded);
	});
	const rawQ = rawAndConditions.join("&");
	const encodedQ = encodedAndConditions.join("&");
	return { raw: rawQ, encoded: encodedQ };
};

const parseOrQuery = (orQuery: FilterQuery[]) => {
	if (!orQuery) throw new Error("invalid query");
	const rawOrConditions: string[] = [];

	orQuery.forEach((query: FilterQuery) => {
		const { raw } = parseQuery(query);
		rawOrConditions.push(raw);
	});
	const params = new URLSearchParams();
	params.set("[or]", `(${rawOrConditions.join(";")})`);
	const rawQ = `[or]=(${rawOrConditions.join(";")})`;
	return { raw: rawQ, encoded: params.toString() };
};

export const parseQuery = (query: Query) => {
	let andQuery = { raw: "", encoded: "" };
	if (query.and) {
		andQuery = parseAndQuery(query.and);
		delete query.and;
	}

	let orQuery = { raw: "", encoded: "" };
	if (query.or) {
		orQuery = parseOrQuery(query.or);
		delete query.or;
	}

	const rawQuery = stringify(query, { encode: false, arrayFormat: "comma" });
	const encodedQuery = stringify(query, { arrayFormat: "comma" });
	const raw = [rawQuery, orQuery.raw, andQuery.raw].filter((queryString) => queryString).join("&");
	const encoded = [encodedQuery, orQuery.encoded, andQuery.encoded]
		.filter((queryString) => queryString)
		.join("&");
	return { raw, encoded };
};

export const createClient = ({ spaceUid, token, apiType = "cdn" }: CreateClientParams) => {
	if (!spaceUid) throw new Error("spaceUid parameter is required.");
	if (!token) throw new Error("token parameter is required.");
	if (!["cdn", "api"].includes(apiType))
		throw new Error(`apiType parameter should be set to "cdn" or "api". apiType: ${apiType}`);

	const baseUrl = new URL(`https://${spaceUid}.${apiType}.newt.so`);
	const headers = { Authorization: `Bearer ${token}` };

	const getContents = async <T>({
		appUid,
		modelUid,
		query
	}: GetContentsParams): Promise<Contents<T>> => {
		if (!appUid) throw new Error("appUid parameter is required.");
		if (!modelUid) throw new Error("modelUid parameter is required.");

		const url = new URL(`/v1/${appUid}/${modelUid}`, baseUrl.toString());
		if (query && Object.keys(query).length) {
			const { encoded } = parseQuery(query);
			url.search = encoded;
		}

		const response = await fetch(url, { headers });
		if (!response.ok) {
			throw new Error("Reponse error!");
		}
		const json = await response.json();
		return json;
	};

	const getContent = async <T>({
		appUid,
		modelUid,
		contentId,
		query
	}: GetContentParams): Promise<T> => {
		if (!appUid) throw new Error("appUid parameter is required.");
		if (!modelUid) throw new Error("modelUid parameter is required.");
		if (!contentId) throw new Error("contentId parameter is required.");

		const url = new URL(`/v1/${appUid}/${modelUid}/${contentId}`, baseUrl.toString());
		if (query && Object.keys(query).length) {
			const { encoded } = parseQuery(query);
			url.search = encoded;
		}

		const response = await fetch(url, { headers });
		if (!response.ok) {
			throw new Error("Reponse error!");
		}
		const json = await response.json();
		return json;
	};

	const getFirstContent = async <T>({
		appUid,
		modelUid,
		query
	}: GetFirstContentParams): Promise<T | null> => {
		if (query && query.limit) {
			throw new Error("query.limit parameter cannot have a value.");
		}
		const q = { ...query, limit: 1 };

		const { items } = await getContents<T>({ appUid, modelUid, query: q });
		if (items.length === 0) return null;
		return items[0];
	};

	const getApp = async ({ appUid }: GetAppParams): Promise<AppMeta> => {
		if (!appUid) throw new Error("appUid parameter is required.");
		const url = new URL(`/v1/space/apps/${appUid}`, baseUrl.toString());

		const response = await fetch(url, { headers });
		if (!response.ok) {
			throw new Error("Reponse error!");
		}
		const json = await response.json();
		return json;
	};

	return {
		getContents,
		getContent,
		getFirstContent,
		getApp
	};
};
