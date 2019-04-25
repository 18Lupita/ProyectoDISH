<div class="fieldcontain <g:if test="${required}">required</g:if> ${hasErrors(bean: bean, field: property, 'has-error')}">
	<label for="${property}"><g:message code="${label}" default="${label}" /><g:if test="${required}">&nbsp;<span class="required-indicator">*</span></g:if></label>
    <input type="text" id="${(prefix ?: '') + property}" name="${(prefix ?: '') + property}" value="${value}" 
        <g:if test="${required}">required=""</g:if>
    />
    <div style="margin-top:3px;">
		<label>&nbsp;</label>
		Restan <span id="counter${property}"></span> carácteres.
    </div>
    <g:hasErrors bean="${bean}" field="${property}">
        <g:eachError bean="${bean}" field="${property}" as="list"><span class="help-block help-block-error m-b-none text-danger"><g:message error="${it}" /></span></g:eachError>
    </g:hasErrors>
</div>
