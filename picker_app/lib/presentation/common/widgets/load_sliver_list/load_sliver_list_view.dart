import 'package:flutter/material.dart';
import 'package:picker/common/common.dart';
import 'package:picker/domain/entity/entity.dart';
import 'package:picker/presentation/common/widgets/list_item_layout.dart';
import 'package:picker/presentation/models/models.dart';

import 'load_sliver_list.dart';

class _GroupHeader extends StatelessWidget {
  final List<Group> groups;
  final int index;
  final GroupHeaderSliverBuilder builder;

  _GroupHeader({
    required this.groups,
    required this.index,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    final isHidden = groups.isGroupHeaderHidden(index: index);
    if (isHidden) {
      return const SliverToBoxAdapter(
        child: SizedBox.shrink(),
      );
    }

    return builder(
      groups.groupHeaderTitle(index: index),
      groups,
      groups.indexOfGroup(index: index),
      extraData: groups.groupHeaderExtraData(index: index),
    );
  }
}

class LoadSliverListView<T extends Entity> extends StatelessWidget {
  LoadSliverListView({
    Key? key,
    required this.items,
    required this.supportFlatGroup,
    required this.shouldShowPlaceholder,
    this.groupHeaderSliverBuilder,
    this.groupItemSliverBuilder,
    this.itemSliverBuilder,
    this.itemSliverPlaceholderBuilder,
    this.groupItemSliverPlaceholderBuilder,
  }) : super(key: key);

  final List<Object> items;
  final bool supportFlatGroup;
  final bool shouldShowPlaceholder;
  final GroupHeaderSliverBuilder? groupHeaderSliverBuilder;
  final GroupItemSliverBuilder? groupItemSliverBuilder;
  final ItemSliverBuilder<T>? itemSliverBuilder;
  final ItemSliverPlaceholderBuilder<T>? itemSliverPlaceholderBuilder;
  final GroupItemSliverPlaceholderBuilder? groupItemSliverPlaceholderBuilder;

  @override
  Widget build(BuildContext context) {
    if (supportFlatGroup) {
      assert(groupItemSliverBuilder != null && groupHeaderSliverBuilder != null,
          '''Must provide builder for group 
            item in case support flat group''');

      final groups = asT<List<Group>>(items)!;

      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            if (groups.isGroupHeader(index: index)) {
              return _GroupHeader(
                groups: groups,
                index: index,
                builder: (headerTitle, groups, index, {extraData}) =>
                    groupHeaderSliverBuilder!(
                  headerTitle,
                  groups,
                  index,
                  extraData: extraData,
                ),
              );
            }
            final item = groups.groupItem(index: index);
            if (item != null) {
              return groupItemSliverPlaceholderBuilder != null
                  ? ListItemLayout(
                      shouldShowPlaceholder: shouldShowPlaceholder,
                      placeholder: groupItemSliverPlaceholderBuilder!(item),
                      child: groupItemSliverBuilder != null
                          ? groupItemSliverBuilder!(item, index)
                          : const SizedBox.shrink(),
                    )
                  : (groupItemSliverBuilder != null
                      ? groupItemSliverBuilder!(item, index)
                      : const SizedBox.shrink());
            }

            return const SizedBox.shrink();
          },
          childCount: groups.totalItemWithHeader(),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => itemSliverPlaceholderBuilder != null
            ? ListItemLayout(
                shouldShowPlaceholder: shouldShowPlaceholder,
                placeholder:
                    itemSliverPlaceholderBuilder!(asT<T>(items[index])!),
                child: itemSliverBuilder != null
                    ? itemSliverBuilder!(asT<T>(items[index])!, index)
                    : const SizedBox.shrink(),
              )
            : (itemSliverBuilder != null
                ? itemSliverBuilder!(asT<T>(items[index])!, index)
                : const SizedBox.shrink()),
        childCount: items.length,
      ),
    );
  }
}
