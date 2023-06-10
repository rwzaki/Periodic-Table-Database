PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  NO_EXISENCE_MSG() {
    echo "I could not find that element in the database."
  }

  DESCRIPTION_OUTPUT_MSG(){
    echo "The element with atomic number $1 is $2 ($3). It's a $4, with a mass of $5 amu. $2 has a melting point of $6 celsius and a boiling point of $7 celsius."
  }

  # This if statement is for checking the validity of the input type 
  # This checks if the input is atomic_number 
  if [[ $1 =~ ^[0-9]+$ ]]
  then 
    # check the existence of the atomic number
    CHECK_INPUT_EXISTENCY=$($PSQL "SELECT COUNT(*) FROM elements WHERE atomic_number = $1; ")

    # if $CHECK_INPUT_EXISTENCY is 1, it means the atommic number exists
    if [[ $CHECK_INPUT_EXISTENCY -eq 1 ]] 
    then
      # since the input is valid and existing, it will be assigned to a variable
      ATOMIC_NUMBER=$1

      # Fetching the rest of the properties from the database using the atomic number
      ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$ATOMIC_NUMBER;")
      ELEMENT_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ATOMIC_NUMBER;")
      ELEMENT_TYPE=$($PSQL "SELECT types.type FROM types INNER JOIN properties USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER;")
      ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER;")
      MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER;")
      BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER;")

      # The output message of the element's description
      DESCRIPTION_OUTPUT_MSG $ATOMIC_NUMBER "$ELEMENT_NAME" "$ELEMENT_SYMBOL" "$ELEMENT_TYPE" $ATOMIC_MASS $MELTING_POINT $BOILING_POINT 
    else # if the input valid but doesn't exist in the database
      NO_EXISENCE_MSG
    fi

  # This checks if the input is symbol
  elif [[ $1 =~ ^[A-Za-z]{1,2}$ ]]
  then 
    # check the existence of the symbol
    CHECK_INPUT_EXISTENCY=$($PSQL "SELECT COUNT(*) FROM elements WHERE symbol ILIKE '$1'; ")

    # if $CHECK_INPUT_EXISTENCY is 1, it means the symbol exists
    if [[ $CHECK_INPUT_EXISTENCY -eq 1 ]] 
    then

      # since the input is valid and existing, it will be assigned to a variable
      ELEMENT_SYMBOL=$1

      # Fetching the rest of the properties from the database using the symbol
      ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol ILIKE '$ELEMENT_SYMBOL';")
      ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$ATOMIC_NUMBER;")
      ELEMENT_TYPE=$($PSQL "SELECT types.type FROM types INNER JOIN properties USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER;")
      ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER;")
      MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER;")
      BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER;")

      # The output message of the element's description
      DESCRIPTION_OUTPUT_MSG $ATOMIC_NUMBER "$ELEMENT_NAME" "$ELEMENT_SYMBOL" "$ELEMENT_TYPE" $ATOMIC_MASS $MELTING_POINT $BOILING_POINT   else # if the input valid but doesn't exist in the database
    else # if the input valid but doesn't exist in the database
      NO_EXISENCE_MSG
    fi
  # This checks if the input is an element's name
  elif [[ $1 =~ ^[A-Za-z]{3,}$ ]]
  then
    # check the existence of the element's name
    CHECK_INPUT_EXISTENCY=$($PSQL "SELECT COUNT(*) FROM elements WHERE name ILIKE '$1'; ")

    # if $CHECK_INPUT_EXISTENCY is 1, it means the element's name exists
    if [[ $CHECK_INPUT_EXISTENCY -eq 1 ]] 
    then
      # since the input is valid and existing, it will be assigned to a variable
      ELEMENT_NAME=$1

      # Fetching the rest of the properties from the database using the element's name
      ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name ILIKE '$ELEMENT_NAME';")
      ELEMENT_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ATOMIC_NUMBER;")
      ELEMENT_TYPE=$($PSQL "SELECT types.type FROM types INNER JOIN properties USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER;")
      ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER;")
      MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER;")
      BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER;")
      
      # The output message of the element's description
      DESCRIPTION_OUTPUT_MSG $ATOMIC_NUMBER "$ELEMENT_NAME" "$ELEMENT_SYMBOL" "$ELEMENT_TYPE" $ATOMIC_MASS $MELTING_POINT $BOILING_POINT   else # if the input valid but doesn't exist in the database
    else # if the input valid but doesn't exist in the database
      NO_EXISENCE_MSG
    fi
  fi
fi
