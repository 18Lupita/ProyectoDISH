<li class="fieldcontain <g:if test="${required}">required</g:if> ${hasErrors(bean: bean, field: property, 'has-error')}">
	<span id="${property}-label" class="property-label"><g:message code="${label}" default="${label}" /><g:if test="${required}"><span style="color:red">&nbsp;*</span></g:if></span>
	</br>
    <input type="text" name="${(prefix ?: '') + property}" value="${value}" id="${property}"
        <g:if test="${required}">required=""</g:if>
    />
    <g:hasErrors bean="${bean}" field="${property}">
        <g:eachError bean="${bean}" field="${property}" as="list"><span class="help-block help-block-error m-b-none text-danger"><g:message error="${it}" /></span></g:eachError>
    </g:hasErrors>
</li>
