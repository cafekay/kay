export type CaseCategory =
  | "brand-identity"
  | "commercial-film"
  | "digital-creation"
  | "brand-experience";

export interface WorkCase {
  id: string;
  slug: string;
  title: string;
  category: CaseCategory;
  categoryLabel: string;
  cover: string;
  preview?: string;
  previewStart?: number;
  orientation?: "landscape" | "portrait";
  featuredOrder?: number;
}

const labels: Record<CaseCategory, string> = {
  "brand-identity": "Brand Identity",
  "commercial-film": "Commercial Film",
  "digital-creation": "Digital Creation",
  "brand-experience": "Brand Experience"
};

const work = (
  id: string,
  title: string,
  category: CaseCategory,
  options: Pick<WorkCase, "preview" | "previewStart" | "orientation" | "featuredOrder"> = {}
): WorkCase => ({
  id,
  slug: id,
  title,
  category,
  categoryLabel: labels[category],
  cover: `/works/${id}/cover.webp${options.preview ? "?v=source-visible-start-20260718-v2" : ""}`,
  ...options,
  preview: options.preview ? `${options.preview}?v=full-length-20260718-v2` : undefined
});

export const cases: WorkCase[] = [
  work("brand-identity-01", "苏泊尔品牌标志视觉升级", "brand-identity", { featuredOrder: 1 }),
  work("brand-identity-02", "苏泊尔品牌文化视觉应用", "brand-identity"),
  work("brand-identity-03", "竹荪家品牌视觉设计", "brand-identity", { orientation: "portrait", featuredOrder: 6 }),
  work("brand-identity-04", "佰欧克产品包装设计", "brand-identity"),

  work("commercial-film-01", "御茶坊", "commercial-film", {
    preview: "/works/commercial-film-01/preview.mp4",
    featuredOrder: 3
  }),
  work("commercial-film-02", "中和休闲", "commercial-film", {
    preview: "/works/commercial-film-02/preview.mp4",
    previewStart: 2
  }),
  work("commercial-film-03", "探店分享", "commercial-film", {
    preview: "/works/commercial-film-03/preview.mp4",
    orientation: "portrait"
  }),
  work("commercial-film-04", "水陆集团初五迎财神", "commercial-film", {
    preview: "/works/commercial-film-04/preview.mp4"
  }),

  work("digital-creation-01", "玲珑紧致面霜", "digital-creation", {
    preview: "/works/digital-creation-01/preview.new.mp4",
    featuredOrder: 2
  }),
  work("digital-creation-02", "糖果乐园", "digital-creation", {
    preview: "/works/digital-creation-02/preview.mp4",
    featuredOrder: 5
  }),
  work("digital-creation-03", "佰欧克素颜芙蓉套装", "digital-creation", {
    preview: "/works/digital-creation-03/preview.mp4",
    orientation: "portrait"
  }),

  work("brand-experience-01", "深蓝天城珠宝门店外立面设计", "brand-experience"),
  work("brand-experience-02", "深蓝天城珠宝展陈空间设计", "brand-experience", { featuredOrder: 4 }),
  work("brand-experience-03", "大白菜普洱茶品牌门店设计", "brand-experience"),
  work("brand-experience-04", "大白菜普洱茶文化展陈设计", "brand-experience"),
  work("brand-experience-05", "寻找自己主题活动策划", "brand-experience"),
  work("brand-experience-06", "探索人生主题活动策划", "brand-experience")
];

export const featuredCases = cases
  .filter((item) => item.featuredOrder)
  .sort((a, b) => (a.featuredOrder ?? 99) - (b.featuredOrder ?? 99));

export const categoryLabels = labels;
