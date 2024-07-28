import jenkins.model.*
import hudson.security.*
import jenkins.install.*

def instance = Jenkins.getInstance()

// Set up SQLite JDBC driver
def sqliteDriverClass = 'org.sqlite.JDBC'
def sqliteJdbcUrl = "jdbc:sqlite:/var/jenkins_sqlite/jenkins.db"

// Load SQLite JDBC driver
Thread.currentThread().contextClassLoader.loadClass(sqliteDriverClass)

// Configure Jenkins to use SQLite
instance.setSecurityRealm(new HudsonPrivateSecurityRealm(false, sqliteJdbcUrl, null))

// Disable Jenkins setup wizard
if (!instance.installState.isSetupComplete()) {
    InstallState.INITIAL_SETUP_COMPLETED.initializeState()
}

// Create admin user
def user = instance.getSecurityRealm().createAccount("admin", "admin")
user.save()

// Configure authorization strategy
def strategy = new hudson.security.FullControlOnceLoggedInAuthorizationStrategy()
strategy.setAllowAnonymousRead(false)
instance.setAuthorizationStrategy(strategy)

// Save the configuration
instance.save()