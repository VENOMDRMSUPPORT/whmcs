<?php
/* Smarty version 3.1.48, created on 2026-02-21 11:13:40
  from '88fc28b4e13b2899a005652b24896ce317022de8' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.48',
  'unifunc' => 'content_699993646e0880_43177314',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_699993646e0880_43177314 (Smarty_Internal_Template $_smarty_tpl) {
?><div class="wizard-transition-step">
    <div class="icon"><i class="far fa-lightbulb"></i></div>
    <div class="title"><?php echo call_user_func_array( $_smarty_tpl->smarty->registered_plugins[Smarty::PLUGIN_FUNCTION]['lang'][0], array( array('key'=>"wizard.welcome"),$_smarty_tpl ) );?>
</div>
    <div class="tag"><?php echo call_user_func_array( $_smarty_tpl->smarty->registered_plugins[Smarty::PLUGIN_FUNCTION]['lang'][0], array( array('key'=>"wizard.intro"),$_smarty_tpl ) );?>
</div>
    <div class="greyout"><?php echo call_user_func_array( $_smarty_tpl->smarty->registered_plugins[Smarty::PLUGIN_FUNCTION]['lang'][0], array( array('key'=>"wizard.noTime"),$_smarty_tpl ) );?>
</div>
</div><?php }
}
