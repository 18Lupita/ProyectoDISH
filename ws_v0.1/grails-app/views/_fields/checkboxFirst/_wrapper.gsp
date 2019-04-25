<div class="fieldcontain <g:if test="${required}">required</g:if> ${hasErrors(bean: bean, field: property, 'has-error')}" style="valign:middle;margin-top: 0px !important;">
    <input type="hidden" name="_${(prefix ?: '') + property}" />
    <input type="checkbox" name="${(prefix ?: '') + property}" id="${(prefix ?: '') + property}" style="display:inline;"<g:if test="${required}"> required=""</g:if><g:if test="${value == true}"> checked="checked"</g:if>/>&nbsp;&nbsp;&nbsp;<label for="${(prefix ?: '') + property}" style="color: #666666;display:inline;"><g:message code="${label}" default="${label}" />${required? '*' : '' }</label>
    <g:hasErrors bean="${bean}" field="${property}">
        <g:eachError bean="${bean}" field="${property}" as="list"><span class="help-block help-block-error m-b-none text-danger"><g:message error="${it}" /></span></g:eachError>
    </g:hasErrors>
</div>
