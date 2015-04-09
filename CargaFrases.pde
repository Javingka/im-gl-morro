class CargaFrases {
  private String frases[];
  int letrasXlinea;
  ArrayList <String> linhas;
  int cantLinhas;
  
  CargaFrases ( String frases_path, int lxl) {
    frases = loadStrings("frases.csv");//loadStrings("DATALOG_dia04_ed.CSV");
    letrasXlinea = lxl;
    linhas = new ArrayList <String>();
    cantLinhas = frases.length;
  } 
  
  void getFrases(int index) {
    if ( !linhas.isEmpty() )
      linhas.clear();
      
    int largoFraseCompleta = frases[index].length();
//    println ("largoFraseCompleta: "+largoFraseCompleta);
    int letrasUltimaLinea = largoFraseCompleta % letrasXlinea; //as palabras da ultima linha
//    println ("letrasUltimaLinea: "+letrasUltimaLinea);
      int cantLineas;
      if (letrasUltimaLinea >= 0)
        cantLineas = (largoFraseCompleta / letrasXlinea) +1; //cantidade de linhas da frase
      else
        cantLineas = (largoFraseCompleta / letrasXlinea); //cantidade de linhas da frase
//      println ("cantLineas: "+cantLineas);
      int corteFrase = 0;
      int corteFinal = largoFraseCompleta;
      for (int f = 0 ; f < cantLineas ; f++) { //se preenche o array 
          int corteInicio = corteFrase;
          corteFrase = corteInicio + letrasXlinea;
     
          if (f == cantLineas-1) {
            linhas.add ( frases[index].substring(corteInicio, corteFinal) );
            println ("frase "+f+": "+frases[index].substring(corteInicio, corteFinal) );
          } else {
            while (frases[index].charAt(corteFrase) != ' ' ) 
              corteFrase--;
            
            linhas.add ( frases[index].substring(corteInicio, corteFrase) );            
            println ("frase "+f+": "+frases[index].substring(corteInicio, corteFrase) );
          }
      }
  }
  
  int numeroLinhas () {
    return linhas.size();
  }
  
  String[] linhasFrase () {
    String[] lnh;
    lnh = linhas.toArray(new String[linhas.size()]); //convierte arrayLit en array
    return  lnh;
  }
  
}
