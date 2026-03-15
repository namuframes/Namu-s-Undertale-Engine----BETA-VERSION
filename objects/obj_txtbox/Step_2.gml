if (live_call()) {return live_result}
y = get_if_top() ? 160 : 4
if (instance_exists(creator)) {
	if (creator == obj_shopManager || object_get_parent(creator.object_index) == parShopKeeper) {type = BOX_TYPE.shop}
}