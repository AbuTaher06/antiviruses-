#include <graphics.h>
#include <iostream>
#include <cmath> // For abs() function

using namespace std;

void drawLineBresenham(int x1, int y1, int x2, int y2) {
    // Calculate differences
    int dx = abs(x2 - x1);
    int dy = abs(y2 - y1);

    // Determine the direction of increment
    int sx = (x2 >= x1) ? 1 : -1;
    int sy = (y2 >= y1) ? 1 : -1;

    // Initialize decision parameter
    int err = dx - dy;

    while (true) {
        // Plot the pixel
        putpixel(x1, y1, WHITE);

        // Break when the end point is reached
        if (x1 == x2 && y1 == y2)
            break;

        // Calculate the error and determine the next pixel
        int e2 = 2 * err;

        if (e2 > -dy) {
            err -= dy;
            x1 += sx;
        }

        if (e2 < dx) {
            err += dx;
            y1 += sy;
        }
    }
}

int main() {
    int gd = DETECT, gm;
    initgraph(&gd, &gm, "");

    // Input line endpoints
    int x1, y1, x2, y2;
    cout << "Enter the starting point (x1, y1): ";
    cin >> x1 >> y1;
    cout << "Enter the ending point (x2, y2): ";
    cin >> x2 >> y2;

    // Draw the line using Bresenham's algorithm
    drawLineBresenham(x1, y1, x2, y2);

    getch();
    closegraph();
    return 0;
}
