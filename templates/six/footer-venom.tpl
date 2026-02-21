
                </div><!-- /.main-content -->
                {if !$inShoppingCart && $secondarySidebar->hasChildren()}
                    <div class="col-md-3 pull-md-left sidebar sidebar-secondary">
                        {include file="$template/includes/sidebar.tpl" sidebar=$secondarySidebar}
                    </div>
                {/if}
            <div class="clearfix"></div>
        </div>
    </div>
</section>

<section id="footer">
    <div class="container">
        <a href="#" class="back-to-top"><i class="fas fa-chevron-up"></i></a>
        
        {* Footer Navigation Links *}
        <div class="footer-links" style="margin-bottom: 1rem;">
            <a href="/terms-of-service.php" style="color: #7a849a; margin: 0 0.75rem;">Terms of Service</a>
            <a href="/privacy-policy.php" style="color: #7a849a; margin: 0 0.75rem;">Privacy Policy</a>
            <a href="/refund-policy.php" style="color: #7a849a; margin: 0 0.75rem;">Refund Policy</a>
            <a href="/acceptable-use.php" style="color: #7a849a; margin: 0 0.75rem;">Acceptable Use</a>
        </div>
        
        {* Software-only disclaimer *}
        <p style="color: #5a6378; font-size: 0.85rem; margin-bottom: 0.5rem;">
            <strong>Software Only · No Content Included</strong> — This license covers server management software only. No content, media, or streaming data is provided.
        </p>
        
        <p>{lang key="copyrightFooterNotice" year=$date_year company="VENOM Solutions"}</p>
    </div>
</section>

<div id="fullpage-overlay" class="hidden">
    <div class="outer-wrapper">
        <div class="inner-wrapper">
            <img src="{$WEB_ROOT}/assets/img/overlay-spinner.svg">
            <br>
            <span class="msg"></span>
        </div>
    </div>
</div>

<div class="modal system-modal fade" id="modalAjax" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content panel-primary">
            <div class="modal-header panel-heading">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                    <span class="sr-only">{$LANG.close}</span>
                </button>
                <h4 class="modal-title"></h4>
            </div>
            <div class="modal-body panel-body">
                {$LANG.loading}
            </div>
            <div class="modal-footer panel-footer">
                <div class="pull-left loader">
                    <i class="fas fa-circle-notch fa-spin"></i>
                    {$LANG.loading}
                </div>
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    {$LANG.close}
                </button>
                <button type="button" class="btn btn-primary modal-submit">
                    {$LANG.submit}
                </button>
            </div>
        </div>
    </div>
</div>

{include file="$template/includes/generate-password.tpl"}

{$footeroutput}

</body>
</html>
