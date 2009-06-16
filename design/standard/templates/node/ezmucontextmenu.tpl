{* Add an "Upload multiple files" item in Admin Content tree context menu*}
<hr/>
<script type="text/javascript">
<!--
menuArray['ContextMenu']['elements']['menu-multiupload'] = new Array();
menuArray['ContextMenu']['elements']['menu-multiupload']['url'] = {"/ezmultiupload/upload/%nodeID%"|ezurl};

// -->
</script>

<a id="menu-multiupload" href="#" onmouseover="ezpopmenu_mouseOver( 'ContextMenu' )" >{"Upload multiple files"|i18n("design/admin/popupmenu")}</a>