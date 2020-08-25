#!/bin/bash

# Grant access to databases which will be created for functional tests of TYPO3
docker_prepare_user_for_functional_testing() {

	if [ -n "$MYSQL_USER" ] && [ -n "$MYSQL_PASSWORD" ]; then
		if [ -n "$MYSQL_DATABASE" ]; then
			mysql_note "Giving user ${MYSQL_USER} access to schema ${MYSQL_DATABASE}_%"
			docker_process_sql --database=mysql <<<"GRANT ALL ON \`${MYSQL_DATABASE//_/\\_}_%\`.* TO '$MYSQL_USER'@'%' ;"
		fi

		docker_process_sql --database=mysql <<<"FLUSH PRIVILEGES ;"
	fi
}

docker_prepare_user_for_functional_testing
