#!C:\xampp\perl\bin\perl.exe
use strict;
use warnings;
use CGI;

print "Content-type: text/html\n\n";
print <<BLOCK;
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <title>Resultado de la Consulta</title>
    <link rel="stylesheet" type="text/css" href="../css/style.css">
</head>
<body>
BLOCK

my $cgi = CGI->new;
my $campo = $cgi->param('campo');
my $valor = $cgi->param('valor');

my $aux;
if(!($valor eq "")){
  open(IN,"../data/ProgramasDeUniversidades.csv") or die "<h1>Error al abrir el archivo.</h1>\n";
  while(my $line = <IN>){
    my %dict = matchLine($line);
    my $result = $dict{$campo};
    if(defined($result) && $result =~ /.*$valor.*/){
      print "<h1>Encontrado:</h1>\n$line\n";
      $aux = 1;
      next;
    }
  }
  close(IN);
}
print <<BLOCK;
</body>
</html>
BLOCK

sub matchLine{
  my %dict = ();
  my $line = $_[0];
  if($line =~ /^[0-9]+\|(.+)\|.+\|.+\|([0-9]+)\|.+\|.+\|.+\|.+\|.+\|(.+)\|.+\|.+\|.+\|.+\|.+\|(.+)\|.+/){
    $dict{"Nombre"} = $1;
    $dict{"Periodo_de_Licenciamiento"} = $2;
    $dict{"Departamento_Local"} = $3;
    $dict{"Denominacion_Programa"} = $4;
  }else{
    print "<h1>Error, datos incorrectos en la línea:</h1>\n$line\n";
  }
  return %dict;
}
