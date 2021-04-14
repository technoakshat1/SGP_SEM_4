export default function buildPostsModel() {
  return function postModel({
    title,
    userId,
    displayName,
    caption,
    categories,
    filters,
    CookingInfo,
    Method,
    comment,
    commentsRepoId,
    media,
    likesRepoId,
  }) {
    return Object({
      title: title,
      userId: userId,
      displayName:displayName,
      caption: caption,
      categories: categories,
      filters: filters,
      CookingInfo: CookingInfo,
      Method: Method,
      comment: comment,
      commentsRepoId: commentsRepoId,
      media: media,
      likesRepoId: likesRepoId,
    });
  };
}
