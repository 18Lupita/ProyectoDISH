<div class="fieldcontain">
    <label for="${property}"><g:message code="${label}" default="${label}" /></label>
    <span id="${property}">
    <g:if test="${value != null}">
		${value}
	</g:if>
	<g:else>
		<g:message code="default.unassigned.label" default="Value not found" />
	</g:else>
	</span>
	<input type="hidden" name="${(prefix ?: '') + property}" id="${(prefix ?: '') + property}" value="${value}" />
</div>
