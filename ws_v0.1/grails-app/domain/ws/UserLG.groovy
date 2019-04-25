package ws
/**
 * @file UserLG.groovy
 * @version 0.1
 * @author Guadalupe Martinez Vazquez
 * @date   24-abril-2019
 * @description Clase UserLG.
 */
import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@EqualsAndHashCode(includes='username')
@ToString(includes='username', includeNames=true, includePackage=false)
class UserLG implements Serializable {

	private static final long serialVersionUID = 1

	//static hasOne = RoleLG

	transient springSecurityService
	
	String	nombre
	String username
	String password
	String password_plain
	boolean enabled = true
	boolean accountExpired
	Date	expireDate
	boolean accountLocked
	boolean passwordExpired
	Date	dateCreated
    Date	lastUpdated
    UserLG	id_Autor
    
	UserLG(String username, String password, String nombre) {
		this()
		this.username = username
		this.password = password
		this.nombre = nombre
		password_plain = password
	}

	Set<RoleLG> getAuthorities() {
		UserLGRoleLG.findAllByUserLG(this)*.roleLG
	}

	def getRol() {
		if (UserLGRoleLG.findByUserLG(this))
			UserLGRoleLG.findByUserLG(this)*.roleLG.authority.first();
	}
	
	def getRolID() {
		if (UserLGRoleLG.findByUserLG(this))
			UserLGRoleLG.findByUserLG(this)*.roleLG?.id.first();
	}

	def getRolName() {
		if (UserLGRoleLG.findByUserLG(this))
			UserLGRoleLG.findByUserLG(this)*.roleLG.nombre.first();
	}

	def beforeInsert() {
		password_plain = password
		encodePassword()
	}

	def beforeUpdate() {
		password_plain = password
		if (isDirty('password')) {
			encodePassword()
		}
	}

	protected void encodePassword() {
		password = springSecurityService?.passwordEncoder ? springSecurityService.encodePassword(password) : password
	}

	public void decodePassword(){
		password = password_plain
	}

	static transients = ['springSecurityService']

	static constraints = {
		//urs display: false
		nombre			(blank: false, nullable:false)
		username		(blank: false, unique: true)
		password		(blank: false)
		password_plain	(display:false, widget:'hiddenField')
		expireDate		(nullable:true)
		dateCreated		(widget:'display')
        lastUpdated		(widget:'display')
        id_Autor		(blank: true, nullable:true, widget:'display')
	}

	static mapping = {
		sort nombre: "asc"
		table 'USERLG'
		version false
		//urs cascade: 'all-delete-orphan'
		password column: '`password`'
	}
	
	String toString() {
        return nombre
    }
}
