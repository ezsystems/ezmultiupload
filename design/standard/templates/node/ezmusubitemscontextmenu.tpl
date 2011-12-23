{* Add an "Upload multiple files" item in Subitems context menu*}
<hr/>
<script type="text/javascript">
menuArray['SubitemsContextMenu']['elements']['child-menu-multiupload'] = new Array();
menuArray['SubitemsContextMenu']['elements']['child-menu-multiupload']['url'] = {"/ezmultiupload/upload/%nodeID%"|ezurl};
</script>

<a id="child-menu-multiupload" href="#" onmouseover="ezpopmenu_mouseOver( 'ContextMenu' )" >{"Upload multiple files"|i18n("design/admin/popupmenu")}</a>
