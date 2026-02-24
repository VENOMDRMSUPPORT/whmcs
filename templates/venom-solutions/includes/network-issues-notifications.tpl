{if $openNetworkIssueCounts.open > 0}
    <div class="alert alert-warning network-issue-alert m-0">
        <div class="container">
            <i class="fas fa-exclamation-triangle fa-fw"></i>
            {lang key='networkIssuesAware'}
        </div>
    </div>
{elseif $openNetworkIssueCounts.scheduled > 0}
    <div class="alert alert-info network-issue-alert m-0">
        <div class="container">
            <i class="fas fa-info-circle fa-fw"></i>
            {lang key='networkIssuesScheduled'}
        </div>
    </div>
{/if}
