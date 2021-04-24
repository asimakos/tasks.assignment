
<cfif structKeyExists(rc.user_activation, "success")>

	<h3>Ο λογαριασμός σας μόλις έχει ενεργοποιηθεί!</h3> 

<cfelseif structKeyExists(rc.user_activation, "error")>

    <h3>Δυστυχώς προέκυψε ένα σφάλμα και ο λογαριασμός σας δεν μπορεί να ενεργοποιηθεί!</h3>

</cfif>
