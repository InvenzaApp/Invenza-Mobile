import 'package:app/cubit/user_cubit/user_cubit.dart';
import 'package:app/extensions/app_localizations.dart';
import 'package:app/extensions/color_extension.dart';
import 'package:app/features/organization/models/organization.dart';
import 'package:app/shared/select_template/view/i_form_organization_select_page/widgets/i_form_organization_select_view.dart';
import 'package:app/shared/widgets/i_app_bar.dart';
import 'package:app/shared/widgets/i_button.dart';
import 'package:app/variables.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IFormOrganizationSelectPage extends StatefulWidget {
  const IFormOrganizationSelectPage({
    this.initialList,
    super.key,
  });

  final List<int>? initialList;

  @override
  State<IFormOrganizationSelectPage> createState() =>
      _IFormOrganizationSelectPageState();
}

class _IFormOrganizationSelectPageState
    extends State<IFormOrganizationSelectPage> {
  List<int> selectedEntities = [];

  @override
  void initState() {
    super.initState();

    if (widget.initialList?.isNotEmpty ?? false) {
      setState(() {
        selectedEntities = widget.initialList!;
      });
    }
  }

  void onSelectAll(
    List<Organization> organizationsList,
    int selectedOrganizationId,
  ) {
    setState(() {
      selectedEntities = organizationsList
          .where((e) => e.id != selectedOrganizationId)
          .map((e) => e.id).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final organizationsList = context.read<UserCubit>().state.organizationsList;
    final selectedOrganizationId =
        context.read<UserCubit>().state.selectedOrganizationId!;
    final l10n = context.l10n;

    return Scaffold(
      appBar: iAppBar(
        context: context,
        title: l10n.select,
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: context.surface,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () =>
                      onSelectAll(organizationsList, selectedOrganizationId),
                  child: Text(l10n.selectAll),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      selectedEntities = [];
                    });
                  },
                  child: Text(l10n.unselectAll),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: mediumPadding,
              child: SingleChildScrollView(
                child: Column(
                  spacing: mediumValue,
                  children: organizationsList
                      .where((e) => e.id != selectedOrganizationId)
                      .map((organization) {
                    return IFormOrganizationSelectView(
                      isSelected: selectedEntities.contains(organization.id),
                      organization: organization,
                      onChanged: (selected) {
                        setState(() {
                          if (selectedEntities.contains(organization.id)) {
                            selectedEntities.remove(organization.id);
                          } else {
                            selectedEntities.add(organization.id);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          Container(
            padding: largePadding,
            decoration: BoxDecoration(
              color: context.container,
            ),
            child: Column(
              children: [
                IButton(
                  label: l10n.save,
                  onPressed: () {
                    if (selectedEntities.isEmpty) {
                      context.maybePop(<int>[]);
                    } else {
                      context.maybePop(selectedEntities);
                    }
                  },
                ),
                SizedBox(height: mediumValue),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
