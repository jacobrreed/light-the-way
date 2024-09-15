using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Movement : MonoBehaviour
{
  [SerializeField] private float speed = 3f;

  private Rigidbody2D body;
  private Animator animator;
  private Vector2 movement;

  private

  void Start()
  {
    body = GetComponent<Rigidbody2D>();
    animator = GetComponent<Animator>();
  }

  void Update()
  {
    movement.x = Input.GetAxisRaw("Horizontal");
    movement.y = Input.GetAxisRaw("Vertical");
    // if horizontal movement is occuring at all, disable vertical movement
    if (Mathf.Abs(movement.x) > Mathf.Abs(movement.y))
    {
      movement.y = 0; // set to 0 so you can't move vertically
      // Set animator values for vertical/horizontal
      animator.SetFloat("y", 0);
      animator.SetFloat("x", movement.x);
      if (movement.x == 1 || movement.x == -1)
      {
        animator.SetFloat("lastX", movement.x);
        animator.SetFloat("lastY", 0);
      }
    }
    else // if vertical movement is occuring at all, disable horizontal movement
    {
      movement.x = 0; // set to 0 so you can't move horizontally
      animator.SetFloat("x", 0);
      animator.SetFloat("y", movement.y);
      if (movement.y == 1 || movement.y == -1)
      {
        animator.SetFloat("lastY", movement.y);
        animator.SetFloat("lastX", 0);
      }
    }
  }


  private void FixedUpdate()
  {
    body.velocity = new Vector2(movement.x * speed, movement.y * speed);
  }
}
