<center>
<div class="fieldcontain <g:if test="${required}">required</g:if> ${hasErrors(bean: bean, field: property, 'has-error')}" style="height:230px;">
	<g:if test="${value}">
		<img id="${(prefix ?: '') + property}-img" src="${request.contextPath}/assets/upload/${value}" style="width:200px;height:200px;" />
	</g:if>
	<g:else>
		<img id="${(prefix ?: '') + property}-img" src="${request.contextPath}/assets/upload/default.png" style="width:200px;height:200px;" />
	</g:else>
	</br>
	<input type="file" accept='image/*' id="tmp-${(prefix ?: '') + property}" name="tmp-${(prefix ?: '') + property}" 
	<g:if test="${required}">required=""</g:if> onchange="PreviewImage('tmp-${(prefix ?: '') + property}','${(prefix ?: '') + property}-img');" />
</div>
</center>
<br>
