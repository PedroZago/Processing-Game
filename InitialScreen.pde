class InitialScreen extends Screen {
  InitialScreen() {
    super();
  }

  void display() {
    image(backgroundInitialScreen, 0, 0);

    textFont(customFont);
    textSize(70);
    fill(255);
    text("Space guardian", width / 2, height / 4);

    drawButton(width / 2, height / 2 - 50, "Play");

    drawButton(width / 2, height / 2 + 50, "Créditos");

    drawButton(width / 2, height / 2 + 150, "História");
  }

}
