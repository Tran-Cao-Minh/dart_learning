import 'package:flutter/material.dart';
import 'package:picker/common/common.dart';
import 'package:picker/domain/entity/entity.dart';
import 'package:picker/presentation/common/widgets/list_item_layout.dart';
import 'package:picker/presentation/models/models.dart';

import 'load_list.dart';

class _GroupHeader extends StatelessWidget {
  final List<Group> groups;
  final int index;
  final GroupHeaderBuilder builder;

  _GroupHeader({
    required this.groups,
    required this.index,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    final isHidden = groups.isGroupHeaderHidden(index: index);
    if (isHidden) {
      return const SizedBox.shrink();
    }

    return builder(
      groups.groupHeaderTitle(index: index),
      extraData: groups.groupHeaderExtraData(index: index),
    );
  }
}

class LoadListView<T extends Entity> extends StatelessWidget {
  LoadListView({
    Key? key,
    required this.items,
    required this.scrollController,
    this.itemSeparatorBuilder,
    this.groupItemBuilder,
    this.groupHeaderBuilder,
    this.groupItemPlaceholderBuilder,
    this.itemPlaceholderBuilder,
    this.itemBuilder,
    required this.supportFlatGroup,
    required this.shrinkWrap,
    required this.isManualScrollControl,
    required this.shouldShowPlaceholder,
    this.padding,
    this.scrollPhysics,
  }) : super(key: key);

  final ScrollController scrollController;
  final bool supportFlatGroup;
  final bool shrinkWrap;
  final bool isManualScrollControl;
  final bool shouldShowPlaceholder;
  final List<Object> items;
  final ItemSeparatorBuilder? itemSeparatorBuilder;
  final GroupItemBuilder? groupItemBuilder;
  final GroupHeaderBuilder? groupHeaderBuilder;
  final GroupItemPlaceholderBuilder? groupItemPlaceholderBuilder;
  final ItemPlaceholderBuilder<T>? itemPlaceholderBuilder;
  final ItemBuilder<T>? itemBuilder;
  final EdgeInsets? padding;
  final ScrollPhysics? scrollPhysics;

  @override
  Widget build(BuildContext context) {
    if (supportFlatGroup) {
      assert(groupItemBuilder != null && groupHeaderBuilder != null,
          'Must provide builder for group item in case support flat group');

      final groups = asT<List<Group>>(items)!;

      if (itemSeparatorBuilder != null) {
        return ListView.separated(
          controller: scrollController,
          shrinkWrap: shrinkWrap,
          padding: padding ?? EdgeInsets.all(dimen_16.w),
          physics: isManualScrollControl
              ? scrollPhysics!
              : scrollPhysics?.toScrollPhysics(),
          itemCount: groups.totalItemWithHeader(),
          separatorBuilder: (_, index) => itemSeparatorBuilder!(index),
          itemBuilder: (_, index) {
            if (groups.isGroupHeader(index: index)) {
              return _GroupHeader(
                groups: groups,
                index: index,
                builder: (headerTitle, {extraData}) => groupHeaderBuilder!(
                  headerTitle,
                  extraData: extraData,
                ),
              );
            }
            final item = groups.groupItem(index: index);
            if (item != null) {
              return groupItemPlaceholderBuilder != null
                  ? ListItemLayout(
                      shouldShowPlaceholder: shouldShowPlaceholder,
                      placeholder: groupItemPlaceholderBuilder!(item),
                      child: groupItemBuilder != null
                          ? groupItemBuilder!(item)
                          : const SizedBox.shrink(),
                    )
                  : (groupItemBuilder != null
                      ? groupItemBuilder!(item)
                      : const SizedBox.shrink());
            }

            return const SizedBox.shrink();
          },
        );
      } else {
        return ListView.builder(
          controller: scrollController,
          shrinkWrap: shrinkWrap,
          padding: padding ?? EdgeInsets.all(dimen_16.w),
          physics: isManualScrollControl
              ? scrollPhysics!
              : scrollPhysics?.toScrollPhysics(),
          itemCount: groups.totalItemWithHeader(),
          itemBuilder: (_, index) {
            if (groups.isGroupHeader(index: index)) {
              return _GroupHeader(
                groups: groups,
                index: index,
                builder: groupHeaderBuilder!,
              );
            }
            final item = groups.groupItem(index: index);
            if (item != null) {
              return groupItemPlaceholderBuilder != null
                  ? ListItemLayout(
                      shouldShowPlaceholder: shouldShowPlaceholder,
                      placeholder: groupItemPlaceholderBuilder!(item),
                      child: groupItemBuilder != null
                          ? groupItemBuilder!(item)
                          : const SizedBox.shrink(),
                    )
                  : (groupItemBuilder != null
                      ? groupItemBuilder!(item)
                      : const SizedBox.shrink());
            }

            return const SizedBox.shrink();
          },
        );
      }
    }

    if (itemSeparatorBuilder != null) {
      return ListView.separated(
        controller: scrollController,
        shrinkWrap: shrinkWrap,
        padding: padding ?? EdgeInsets.all(dimen_16.w),
        physics: isManualScrollControl
            ? scrollPhysics!
            : scrollPhysics?.toScrollPhysics(),
        itemCount: items.length,
        separatorBuilder: (_, index) => itemSeparatorBuilder!(index),
        itemBuilder: (_, index) => itemPlaceholderBuilder != null
            ? ListItemLayout(
                shouldShowPlaceholder: shouldShowPlaceholder,
                placeholder: itemPlaceholderBuilder!(asT<T>(items[index])!),
                child: itemBuilder != null
                    ? itemBuilder!(asT<T>(items[index])!, index)
                    : const SizedBox.shrink(),
              )
            : (itemBuilder != null
                ? itemBuilder!(asT<T>(items[index])!, index)
                : const SizedBox.shrink()),
      );
    }

    return ListView.builder(
      controller: scrollController,
      shrinkWrap: shrinkWrap,
      padding: padding ?? EdgeInsets.all(dimen_16.w),
      physics: isManualScrollControl
          ? scrollPhysics!
          : scrollPhysics?.toScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (_, index) => itemPlaceholderBuilder != null
          ? ListItemLayout(
              shouldShowPlaceholder: shouldShowPlaceholder,
              placeholder: itemPlaceholderBuilder!(asT<T>(items[index])!),
              child: itemBuilder != null
                  ? itemBuilder!(asT<T>(items[index])!, index)
                  : const SizedBox.shrink(),
            )
          : (itemBuilder != null
              ? itemBuilder!(asT<T>(items[index])!, index)
              : const SizedBox.shrink()),
    );
  }
}
